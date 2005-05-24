From: Stefan Seyfried <seife@suse.de>
Subject: Re: swsusp: Not enough free pages
Date: Tue, 24 May 2005 18:55:14 +0200
Message-ID: <42935C72.9030506@suse.de>
References: <3ACA40606221794F80A5670F0AF15F84041AC1A8@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC1A8@pdsmsx403>
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

Yu, Luming wrote:
> Hi Pavel,
>=20
> I got this error when I'm hacking suspend-to-disk on my IA64 box with 1=
G
> memory.
> (Pagesize 64K,MemTotal:  1002112 kB ,MemFree:  395008 kB)
> Do you plan to improve it by compressing pages ?
> =20
> swsusp: Need to copy 9878 pages
> suspend: (pages needed: 9878 + 512 free: 6486)
> swsusp: Not enough free pages: Have 6486

I have not seen one of those for a long time (on i386). Does this happen
every time? Can you tell from the log if free_some_memory actually freed
some memory?
--=20
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out."
