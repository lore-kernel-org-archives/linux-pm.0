From: "Yu, Luming" <luming.yu@intel.com>
Subject: swsusp: Not enough free pages
Date: Wed, 25 May 2005 00:05:44 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC1A8@pdsmsx403>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6337865227973678=="
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

--===============6337865227973678==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

Hi Pavel,

I got this error when I'm hacking suspend-to-disk on my IA64 box with 1G
memory.
(Pagesize 64K,MemTotal:  1002112 kB ,MemFree:  395008 kB)
Do you plan to improve it by compressing pages ?
 
swsusp: Need to copy 9878 pages
suspend: (pages needed: 9878 + 512 free: 6486)
swsusp: Not enough free pages: Have 6486

Thanks
Luming


--===============6337865227973678==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============6337865227973678==--
