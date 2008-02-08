From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: ACPI_WMI: worst config description of all times
Date: Fri, 8 Feb 2008 02:02:40 +0000
Message-ID: <200802080202.41355.carlos@strangeworlds.co.uk>
References: <20080207214715.GA15211@elf.ucw.cz> <200802080119.08872.carlos@strangeworlds.co.uk> <2c0942db0802071738g2f426d4y6ee9ab58b62d8174@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2c0942db0802071738g2f426d4y6ee9ab58b62d8174@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 08 February 2008 01:38:01 Ray Lee wrote:
> <nod> That's clear to me (whereas the original wasn't), though I would
> still argue for this driver being select'ed by the drivers that
> require it. As you note, other laptop specific drivers do so, and
> Linus has come down in favor of that as well in the past, so you have
> a friend in high places :-).

I have some other patches lined up to do so. Unless I hear some arguments
against it, or some better alternatives, I'll put them together with this
and get Len to apply them to the ACPI tree (and then hopefully push back
out before the -rc1 release).

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
