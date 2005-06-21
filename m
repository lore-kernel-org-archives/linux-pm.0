From: Pavel Machek <pavel@ucw.cz>
Subject: Re: write_page hang in close_swap
Date: Tue, 21 Jun 2005 11:22:45 +0200
Message-ID: <20050621092244.GE1953@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F84088653AE@pdsmsx403>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============72589126671930948=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84088653AE@pdsmsx403>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: ACPI devel <acpi-devel@lists.sourceforge.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============72589126671930948==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> I found a problem in function close_swap (kernel/power/swsusp.c). 
> the first call to write_page just hang on my IA64 platform.:
> 
>   error = write_page((unsigned long)&swsusp_info, &entry);
> 
> But the preceding calls to this function in data_write() and
> write_pagedir() 
> are 100% done without any visible error.
> 
> Have you ever encountered this before on other platform?

No, I've not seen problems in this area before.
							Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.

--===============72589126671930948==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============72589126671930948==--
