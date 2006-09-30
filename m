From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] PowerOP, Whatchanged/Issues/TODO 2/2
Date: Sat, 30 Sep 2006 22:51:15 +0200
Message-ID: <20060930205115.GA3061@elf.ucw.cz>
References: <20060930014412.98405be8.eugeny.mints@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751922AbWI3UvY@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060930014412.98405be8.eugeny.mints@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org, ext-Tuukka.Tikkanen@nokia.com
List-Id: linux-pm@vger.kernel.org

On Sat 2006-09-30 01:44:12, Eugeny S. Mints wrote:
> whatchanged:
> - new concept of powerop power parameter is introduced
> - new powerop core interface routine to set individual(or subset of)
>   power parameter value is added
> - no more string parsing at any layer
> - no more va_list interface 
> - powerop driver module refcounting is added
> - documentation file including optional sysfs interface description is added
> 
> todo/issues:
> - better implementation for getting registered operating point names
> - configfs for operating points creation from user space

You forgot to mention: how to solve the "256 cpus, 2 power states
each" case?

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
