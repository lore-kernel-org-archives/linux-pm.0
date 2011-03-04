From: Simon Horman <horms@verge.net.au>
Subject: pm-qos: Command line wrapper for PM_QOS
Date: Fri, 4 Mar 2011 09:28:11 +0900
Message-ID: <20110304002810.GA18214@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Mark Gross <markgross@thegnar.org>
List-Id: linux-pm@vger.kernel.org

Hi,

below is a small command line utility that I have been
working to allow set and forget of the PM_QOS values of
any command without the need to modify its code.

A lot of the code below deals with dropping privileges
if run setuid or under sudo. That somewhat distracts
from the simplicity of the main functionality.

I would be more than happy if a sensible home could
be found for this code.

/*
 * pm-qos: run a command with pm_qos latency and throughput targets
 *
 * Copyright (C) 2011 Tsuru Capital LLC
 * Author: Simon Horman <horms@verge.net.au>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include <limits.h>
#include <stdint.h>
#include <pwd.h>
#include <grp.h>

#define PM_QOS_CPU_DMA_LATENCY_DEV	"/dev/cpu_dma_latency"
#define PM_QOS_CPU_DMA_LATENCY_DEFAULT	-1
#define PM_QOS_NET_LATENCY_DEV		"/dev/network_latency"
#define PM_QOS_NET_LATENCY_DEFAULT	-1
#define PM_QOS_NET_THROUGHPUT_DEV	"/dev/network_throughput"
#define PM_QOS_NET_THROUGHPUT_DEFAULT	-1

struct options {
	int32_t cpu_dma_latency;
	int32_t network_latency;
	int32_t network_throughput;
};

#define DECLARE_OPTIONS(opt)						\
	struct options opt = {						\
		.cpu_dma_latency = PM_QOS_CPU_DMA_LATENCY_DEFAULT,	\
		.network_latency = PM_QOS_NET_LATENCY_DEFAULT,		\
		.network_throughput = PM_QOS_NET_THROUGHPUT_DEFAULT };

static void __pm_qos(const char *dev, int32_t target, const char *desc)
{
	int fd;
	ssize_t err;

	fd = open(dev, O_RDWR);
	if (fd < 0) {
		switch (errno) {
		case ENOENT:
			fprintf(stderr, "warning: \"%s\" does not exist, "
			        "not setting pm_qos to target %s. "
				"Kernel doesn't have pm_qos support?.\n",
				dev, desc);
			return;
		case EACCES:
			fprintf(stderr, "warning: no permissions to open "
				"\"%s\" for writing, not setting pm_qos "
				"to target %s. Try running as root?\n",
				dev, desc);
			return;
		default:
			fprintf(stderr, "warning: could not open \"%s\", "
			        "not setting pm_qos to target %s: open: %s\n",
				dev, desc, strerror(errno));
			return;
		}
	}

	err = write(fd, &target, sizeof(target));
	if (err < 0) {
		fprintf(stderr, "warning: could not write to \"%s\", "
			"not setting pm_qos to target %s: write: %s\n",
			dev, desc, strerror(errno));
		return;
	}
	if (err != sizeof(target)) {
		fprintf(stderr, "warning: short write to \"%s\", "
			"not setting pm_qos to target %s.\n", dev, desc);
		return;
	}

	/* N.B: Keep fd open.
	 * This retains the pm_qos setting.
	 * See Documentation/power/pm_qos_interface.txt in the kernel
	 * source tree
	 */
	return;
}

static void pm_qos(struct options *opt)
{
	if (opt->cpu_dma_latency >= 0)
		__pm_qos(PM_QOS_CPU_DMA_LATENCY_DEV, opt->cpu_dma_latency,
			 "CPU DMA latency");
	if (opt->network_latency >= 0)
		__pm_qos(PM_QOS_NET_LATENCY_DEV, opt->network_latency,
			 "network latency");
	if (opt->network_throughput >= 0)
		__pm_qos(PM_QOS_NET_THROUGHPUT_DEV, opt->network_throughput,
			 "network throughput");
}

static void usage(const char *ident)
{
	fprintf(stderr,
		"usage:\n"
		"	%s target_cpu_dma_latency target_network_latency target_network_throughput cmd ...\n"
		"\n"
		"	Run a command with pm_qos latency and throughput targets\n"
		"\n"
		"	A negative value for a target indicates that a target\n"
		"	will not be set.\n"
		"\n"
		"	Latency targets are in usec\n"
		"	Network throughput target is in kbit/s\n"
		"\n",
		ident);
	exit (1);
}

static int32_t parse_int32(const char *str, const char *ident)
{
	char *end;
	long val;

	errno = 0;
	val = strtoll(str, &end, 10);
	if ((errno == ERANGE && (val == LLONG_MAX || val == LLONG_MIN)) ||
	    (errno && !val)) {
		perror("strtol");
		usage(ident);
	}
	if (end == str || *end != '\0' || (int32_t)val != val)
		usage(ident);

	return val;
}

static uid_t parse_uid(const char *str)
{
	char *end;
	unsigned long val;

	errno = 0;
	val = strtoull(str, &end, 10);
	if ((errno == ERANGE && val == ULLONG_MAX) || (errno && !val)) {
		perror("strtol");
		goto err;
	}
	if (end == str || *end != '\0' || (uid_t)val != val)
		goto err;

	return val;
err:
	fprintf(stderr, "error: invalid SUDO_UID environment\n");
	exit(1);
}

static gid_t parse_gid(const char *str)
{
	char *end;
	unsigned long val;

	errno = 0;
	val = strtoull(str, &end, 10);
	if ((errno == ERANGE && val == ULLONG_MAX) || (errno && !val)) {
		perror("strtol");
		goto err;
	}
	if (end == str || *end != '\0' || (gid_t)val != val)
		goto err;

	return val;
err:
	fprintf(stderr, "error: invalid SUDO_GID environment\n");
	exit(1);
}

static void drop_privs(void)
{
	const char *uid_str, *gid_str;
	uid_t uid;
	gid_t gid, groups[NGROUPS_MAX];
	struct passwd *pwd;
	int ngroups = 0;

	if (geteuid())
		return; /* not root, nothing to do */

	if (getuid() || getgid()) { /* Running setuid or setgid */
		uid = getuid();
		gid = getgid();
	} else { /* Running under sudo ? */
		uid_str = getenv("SUDO_UID");
		gid_str = getenv("SUDO_GID");

		if (!uid_str && !gid_str)
			return; /* not sudoed, nothing to do */

		if (!uid_str || !gid_str) {
			fprintf(stderr,
				"error: invalid SUDO_UID/SUDO_GID \n"
				"environment\n");
			exit(1);
		}

		uid = parse_uid(uid_str);
		gid = parse_gid(gid_str);

		if (!uid)
			return; /* Sudo run by root, nothing to do */
	}

	while (1) {
		errno = 0;
		pwd = getpwuid(uid);
		if (pwd)
			break;
		switch (errno) {
		case EINTR:
			continue;
		case EIO:
		case ENFILE:
		case ENOMEM:
		case ERANGE:
			perror("getpwname");
			fprintf(stderr,
				"error: can't lookup user %d\n", uid);
			exit(1);
		default:
			fprintf(stderr,
				"warning: can't lookup user %d, "
				"not adding supplementry groups\n", uid);
			break;
		}
	}
	if (pwd) {
		ngroups = NGROUPS_MAX;
		if (getgrouplist(pwd->pw_name, gid, groups, &ngroups) < 0) {
			fprintf(stderr,
				 "error: user \"%s\" is a member of too "
				 "many groups\n", pwd->pw_name);
			exit(1);
		}
		if (setgroups(ngroups, groups)) {
			fprintf(stderr,
				 "error: can't set supplementry groups\n");
			exit(1);
		}
	}

	if (setgid(gid)) {
		perror("setsgid");
		fprintf(stderr, "error: couldn't drop group privilages\n");
		exit(1);
	}

	if (setuid(uid)) {
		perror("setuid");
		fprintf(stderr, "error: couldn't drop user privilages\n");
		exit(1);
	}
}

static void parse_options(int argc, char * const *argv, struct options *opt)
{
	if (argc < 5)
		usage(argv[0]);

	opt->cpu_dma_latency = parse_int32(argv[1], argv[0]);
	opt->network_latency = parse_int32(argv[2], argv[0]);
	opt->network_throughput = parse_int32(argv[3], argv[0]);
}

static void cmd(int argc, char **argv)
{
	memmove(argv, argv + 4, (argc - 4) * sizeof(char *));
	argv[argc - 4] = NULL;
	if (execvp(argv[0], argv))
		perror("execp: ");
}

int main (int argc, char **argv)
{
	DECLARE_OPTIONS(opt);

	parse_options(argc, argv, &opt);

	pm_qos(&opt);

	drop_privs();

	cmd(argc, argv);

	return 0;
}
