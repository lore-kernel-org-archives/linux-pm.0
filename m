From: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.19-rc3: known unfixed regressions: confirmations
Date: Thu, 26 Oct 2006 17:31:42 +0200
Message-ID: <20061026153142.GJ27968@stusta.de>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <20061024202104.GF27968@stusta.de> <453E8921.2090406@wintersgift.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423568AbWJZPbp@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <453E8921.2090406@wintersgift.com>
Sender: linux-kernel-owner@vger.kernel.org
To: teunis <teunis@wintersgift.com>
Cc: linux-kernel@vger.kernel.org, art@usfltd.com, Jiri Slaby <jirislaby@gmail.com>, Jeff Dike <jdike@addtoit.com>, pavel@suse.cz, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 24, 2006 at 02:44:01PM -0700, teunis wrote:
> Adrian Bunk wrote:
> > This email lists some known unfixed regressions in 2.6.19-rc3 compared 
> > to 2.6.18.
> ...
> 
> I'm not directly testing -rc3 as yet...  rc2-mm2 + a few modifications
> works on the equipment I'm testing and as I can't afford more lost time
> due to faults - I'm keeping to that build for the short term.
> 
> > Subject    : shutdown problem
> > References : http://lkml.org/lkml/2006/10/22/140
> > Submitter  : art@usfltd.com
> >              teunis@wintersgift.com
> >              Jiri Slaby <jirislaby@gmail.com>
> > Status     : unknown
> 
> repaired by Jeff Dike's patch to fs/proc/array.c
>...

Can you give me a pointer to this patch?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
