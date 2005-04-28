From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: Re: freeze_processes questions
Date: Thu, 28 Apr 2005 16:21:52 +1000
Message-ID: <1114669311.3580.25.camel@desktop.cunningham.myip.net.au>
References: <1114667366.3580.19.camel@desktop.cunningham.myip.net.au>
	<1114668061.22492.16.camel@sli10-desk.sh.intel.com>
Reply-To: ncunningham@linuxmail.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============99989875872167433=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1114668061.22492.16.camel@sli10-desk.sh.intel.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Li Shaohua <shaohua.li@intel.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============99989875872167433==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Thu, 2005-04-28 at 16:01, Li Shaohua wrote:
> What states should be saved/restored for the dead CPU? The dead CPU is
> in idle thread before becoming dead, so ingoring save/restore general
> registers doesn't matter. Sure there are something which must be
> saved/restored, like the MTRR registers and possible Local APIC
> registers if their value are different with the boot time. But there are
> no much such cases, I think.

Well, I don't have it working perfectly yet, but saving and restoring
MTRRs definitely did make a difference. Prior to that I added the same
save and restore of CPU registers we use at the moment (suspend2 style)
and shifted the irq disable call above the wait loop (so the comment is
true). Given what you say, I'll try reversing the other changes and just
leaving in the MTRR save/restore, then see if it's as reliable as it is
now.

For the record, without anything added, I was getting spontaneous
reboots in the copy back with just hotplug. With everything I have now
added, I'm always making it to the end of the resume, but then getting
seg faults when I try to start apps. Should be simple to fix, but I
won't be trying this evening as I'm going to my last LUG meeting here in
Canberra. We move to Brisbane May 9.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--===============99989875872167433==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============99989875872167433==--
