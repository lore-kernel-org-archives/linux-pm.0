From: "Yu, Luming" <luming.yu@intel.com>
Subject: write_page hang in close_swap
Date: Tue, 21 Jun 2005 17:17:18 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84088653AE@pdsmsx403>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============37442244468925034=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: pavel@suse.cz
Cc: ACPI devel <acpi-devel@lists.sourceforge.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============37442244468925034==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

Hi Pavel,

I found a problem in function close_swap (kernel/power/swsusp.c). 
the first call to write_page just hang on my IA64 platform.:

  error = write_page((unsigned long)&swsusp_info, &entry);

But the preceding calls to this function in data_write() and
write_pagedir() 
are 100% done without any visible error.

Have you ever encountered this before on other platform?

Thanks,
Luming


--===============37442244468925034==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============37442244468925034==--
