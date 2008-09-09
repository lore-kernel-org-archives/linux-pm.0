From: Nick Moszer <nick.moszer@packetdigital.com>
Subject: SATA Link PM & Partial
Date: Tue, 09 Sep 2008 16:25:19 -0500
Message-ID: <48C6E9BF.20103@packetdigital.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
List-Id: linux-pm@vger.kernel.org

Hello,

I've been testing the Linux based SATA link pm capabilities of drives
for a project. I have come across a curious set of drives and wonder if
anyone on the list can shed light on the issues.


Some drives appear never to go to partial on the link when
"medium_power" is written to link_power_management_policy at
/sys/class/scsi_host/hostX..  All drives I've tested will go to slumber
when "min_power" is written.  The drives that do go to partial when set
through sysfs also allow manual transitions, a.k.a writing to the AHCI
port command register directly to force it to a pm mode.  The drives
that do not go to partial when set through sysfs will NOT allow any
manual transitions.


I don't have a SATA bus sniffer handy so I can't see the primitives to
find out exactly what is going on.


The drives I've found that won't go to partial when enabled through
sysfs are:
Seagate Momentus ST9160821AS
Seagate Momentus ST9160823AS
Lite-On DVDRW/CDRW DS-8A2S


I saw the note about DIPM in libata-core.c ata_dev_set_dipm() and
partial.  This does not appear to be the case as everything I'm talking
about is HIPM.  I'm wondering if perhaps some drives just don't support
partial on the link?  Using hdparm -I on the Seagate drives the output
w/ regards to PM is the same "Advanced Power Management" is supported on
both drives that work and don't work.


Does anyone know of a way to tell if these drives actually support
partial and the driver needs work or if these drives just plain don't
support it?  I haven't come across anything in the AHCI or SATA specs
that say if it's optional.  They make it seem like both partial and
slumber are mandatory.

Thanks!

Nick Moszer
