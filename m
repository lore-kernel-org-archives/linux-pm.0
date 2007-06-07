From: Mark Lord <lkml@rtr.ca>
Subject: Re: 2.6.22-rc3 hibernate(?) fails totally - regression (xfs on raid6)
Date: Thu, 07 Jun 2007 10:36:31 -0400
Message-ID: <466817EF.7090707@rtr.ca>
References: <46608E3F.4060201@dgreaves.com> <46609FAD.7010203@dgreaves.com>	 <200706020122.49989.rjw@sisk.pl> <4661EFBB.5010406@dgreaves.com>	 <alpine.LFD.0.98.0706021538360.23741@woody.linux-foundation.org>	 <4662D852.4000005@dgreaves.com> <46667160.80905@gmail.com>	 <46668EE0.2030509@dgreaves.com> <46679D56.7040001@gmail.com>	 <4667DE2D.6050903@dgreaves.com> <e9e943910706070645p29519138i7e76b3a9649d387@mail.gmail.com> <46680F69.60105@dgreaves.com> <46681094.4070103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761335AbXFGOgo@vger.kernel.org>
In-Reply-To: <46681094.4070103@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: David Greaves <david@dgreaves.com>, Duane Griffin <duaneg@dghda.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, xfs@oss.sgi.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.osdl.org>, Neil Brown <neilb@suse.de>
List-Id: linux-pm@vger.kernel.org

Tejun Heo wrote:
>
> Can you setup serial console and/or netconsole (not sure whether this
> would work tho)?

Since he has good console output already, capturable by digicam,
I think a better approach might be to provide a patch with extra instrumentation..
You know.. progress messages and the like, so we can see at what step
things stop working.  Or would that not help ?

David, does scrollback work on your dead console?

Cheers
