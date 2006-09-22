From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Date: Fri, 22 Sep 2006 16:11:27 +0200
Message-ID: <20060922141127.GM3478@elf.ucw.cz>
References: <200609192137.k8JLb4NX029061@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932513AbWIVOLb@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200609192137.k8JLb4NX029061@olwen.urbana.css.mot.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: eugeny.mints@gmail.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> Hmm. If you assume the CPUs in an SMP system can be in different
> operating points, this would (as Pavel pointed out) result in an
> explosion of operating points.

Problem is not only CPUs, devices are mostly independent in PC
case... it would be nice to solve that problem with same approach.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
