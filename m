From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] sysfs switch for disabling device run-time PM
Date: Thu, 21 Jan 2010 23:57:46 +0100
Message-ID: <201001212357.46483.rjw__47113.4584899575$1264114932$gmane$org@sisk.pl>
References: <201001180129.55219.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001180129.55219.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Greg KH <greg@kroah.com>
List-Id: linux-pm@vger.kernel.org

Hi,

The first of the following two patches adds a sysfs switch for controlling the
run-time power management of devices and the second one documents the sysfs
attributes in /sys/devices/.../power/ (including the new one).

Thanks,
Rafael
