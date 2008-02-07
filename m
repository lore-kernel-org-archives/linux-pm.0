From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Thu, 7 Feb 2008 23:53:50 +0100
Message-ID: <200802072353.51092.rjw@sisk.pl>
References: <20080205190600.GB11613@elf.ucw.cz> <200802072340.06138.rjw@sisk.pl> <47AB89CB.7010908@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933642AbYBGWzz@vger.kernel.org>
In-Reply-To: <47AB89CB.7010908@zytor.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 7 of February 2008, H. Peter Anvin wrote:
> Rafael J. Wysocki wrote:
> > -	rep; stosl
> > +	rep
> > +	stosl
> 
> Yuck!
> 
> Please don't perpetuate the braindamage that this is two instructions. 
> It's one instruction with a modifier;

Sure, it is.

> the fact that gas wants a separator is broken enough as it is.

[Well, the newline is a separator too.]  I'll keep it in one line if you want
that.

Rafael
