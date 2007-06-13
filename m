From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.22-rc3 hibernate(?) fails totally - regression (xfs on raid6)
Date: Wed, 13 Jun 2007 17:22:55 -0400
Message-ID: <4670602F.9000908@pobox.com>
References: <200706020122.49989.rjw@sisk.pl> <4661EFBB.5010406@dgreaves.com> <alpine.LFD.0.98.0706021538360.23741@woody.linux-foundation.org> <4662D852.4000005@dgreaves.com> <46667160.80905@gmail.com> <46668EE0.2030509@dgreaves.com> <46679D56.7040001@gmail.com> <4667DE2D.6050903@dgreaves.com> <20070607110708.GS86004887@sgi.com> <46680F5E.6070806@dgreaves.com> <20070607222813.GG85884050@sgi.com> <4669A965.20403@dgreaves.com> <alpine.LFD.0.98.0706121123550.14121@woody.linux-foundation.org> <466FD214.9070603@dgreaves.com> <alpine.LFD.0.98.0706131344550.14121@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755852AbXFMVXY@vger.kernel.org>
In-Reply-To: <alpine.LFD.0.98.0706131344550.14121@woody.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Greaves <david@dgreaves.com>, David Chinner <dgc@sgi.com>, Tejun Heo <htejun@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, xfs@oss.sgi.com, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.osdl.org>, Neil Brown <neilb@suse.de>
List-Id: linux-pm@vger.kernel.org

Linus Torvalds wrote:
> Ok, good. So the bug is apparently in the generic SCSI layer start/stop
> handling. I'm not entirely surprised, most people would never have 
> triggered it (I _think_ it's disabled by default for all devices, and that 
> the libata-scsi.c change was literally the first thing to ever enable it 
> by default for anything!)


I haven't looked at this yet, but wanted to confirm your assessment 
here:  libata was indeed the first (and still only?) user of this code path.

Since some SCSI devices may not be owned by the host computer, in the 
power management sense, we don't want to turn that on for all SCSI 
devices.  Otherwise you wind up powering off a device in another building :)

This is basically the libata suspend/resume path, even though bits touch 
generic SCSI.

	Jeff
