From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Alternative Concept [Was: Re: [RFC] CPUFreq PowerOP
	integration, Intro 0/3]
Date: Fri, 6 Oct 2006 23:15:01 -0400
Message-ID: <20061007031501.GA1404@dominikbrodowski.de>
References: <44ECFF94.3030506@gmail.com>
	<20061007023620.GD30380@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061007023620.GD30380@dominikbrodowski.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Some very basic incomplete sketch of how some of my ideas might look in
code:

 /*
 * OMAP PM Core implementation by Eugeny S. Mints <eugeny.mints@gmail.com>,
 * modified by Dominik Brodowski.
 *
 * Copyright (C) 2006, Nomad Global Solutions, Inc.
 * Copyright (C) 2006  Dominik Brodowski
 *
 * Based on code by Todd Poynor, Matthew Locke, Dmitry Chigirev, and
 * Bishop Brock.
 *
 * Copyright (C) 2002, 2004 MontaVista Software <source@mvista.com>.
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
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
 */

#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>

/* Number of colums in operating points table */
#define OP_VALUES  4


/* GENERIC PART BEGINS HERE */

struct op_entry {
	unsigned int value[OP_VALUES];
	struct op_entry *next;
};

int pm_core_verify_value(unsigned int what, unsigned int value,
			 struct op_entry *table,
			 int set_other(unsigned int, unsigned int))
{
	int i, colum =3D -1;
	struct op_entry *table_entry =3D table->next;

	for (i=3D0; i<OP_VALUES; i++) {
		if (table->value[i] =3D=3D what)
			colum =3D i;
	}
	if (colum =3D=3D -1)
		return -EINVAL;

	while (table_entry) {
		/* very easy algorithm at first: use the first
		   operating point which matches what we are looking
		   for
		*/
		if (table_entry->value[colum] =3D=3D value)
			goto found_it;

		table_entry =3D table_entry->next;
	};
	return -EINVAL;

 found_it:
	for (i=3D0; i<OP_VALUES; i++) {
		if (i=3D=3Dcolum)
			continue;
		/* FIXME: error handling */
		set_other(table->value[i], table_entry->value[i]);
	}
	return 0;
}

/* GENERIC PART ENDS HERE */



/* dummy */
static int set_cpu_vltg(unsigned int value)
{
	return 0;
}

static int set_dpll(unsigned int value)
{
	return 0;
}

static int set_cpu_freq(unsigned int value)
{
	return 0;
}

enum {
	CPU_VLTG =3D 0,
	DPLL =3D 1,
	CPU_FREQ =3D 2,
	OPPOINT_NR =3D 3,
};

static int set_pm(unsigned int what, unsigned int value)
{
	int ret =3D -ENODEV;

	/* FIXME
	pm_core_notify_prechange(what, value);
	*/

	switch (what) {
	case CPU_VLTG:
		/* FIXME: only set it if it is really different
		 * from current level */
		ret =3D set_cpu_vltg(value);
		break;
	case DPLL:
		ret =3D set_dpll(value);
		break;
	case CPU_FREQ:
		ret =3D set_cpu_freq(value);
		break;
	case OPPOINT_NR:
		/* ignore */
		break;
	}

	/* FIXME
	if (!ret)
		pm_core_notify_postchange(what, value);
	else
		pm_core_notify_failed_change(what, value);
	*/

	return ret;
}

/* THE TABLE CONTAING PRE-DEFINED OPERATING POINTS */


/* FIXME: think of a better way to set up a static table */
struct op_entry omap_op_static_entry4 =3D {
	.value =3D {2, 3, 2, 4},
};

struct op_entry omap_op_static_entry3 =3D {
	.value =3D {1, 2, 2, 3},
	.next =3D &omap_op_static_entry4,
};

struct op_entry omap_op_static_entry2 =3D {
	.value =3D {2, 1, 1, 2},
	.next =3D &omap_op_static_entry3,
};

struct op_entry omap_op_static_entry1 =3D {
	.value =3D {1, 1, 1, 1},
	.next =3D &omap_op_static_entry2,
};

struct op_entry omap_op_table =3D {
	.value =3D {CPU_VLTG, DPLL, CPU_FREQ, OPPOINT_NR},
	.next =3D &omap_op_static_entry1,
};


/* function being called by external interface. You can add
   whatever userspace API on top of it you like -- configfs,
   sysfs, module parameter, syscall, ... */

int omap_set(unsigned int what, unsigned int value)
{
	int ret;

	ret =3D pm_core_verify_value(what, value, &omap_op_table, set_pm);
	if (ret)
		return ret;

	return set_pm(what, value);
}


/*
To set a specific operating point, let's say, oppoint 3, the
yet-to-be-defined interface needs to call:

omap_set(OPPOINT_NR, 3);


Setting up a cpufreq interaction is quite easy, as it basically only
needs to call

omap_set(CPU_FREQ, validated_target_freq);

You only need to make sure that you're not using in-kernel CPU
frequency scaling parallel to setting oppoints. But such a validation
should be trivial to add.
*/



IT COMPILES!!! SHIP IT! ;)

Thanks,
	Dominik
