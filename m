From: Shaohua Li <shaohua.li@intel.com>
Subject: RE: Re: swsusp: which page should be saved?
Date: Tue, 21 Mar 2006 11:33:10 +0800
Message-ID: <1142911990.11430.28.camel@sli10-desk.sh.intel.com>
References: <3ACA40606221794F80A5670F0AF15F840B417401@pdsmsx403>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============79559463453120816=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840B417401@pdsmsx403>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============79559463453120816==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-03-21 at 11:23 +0800, Yu, Luming wrote:
> >>> > Anyway, skipping kernel text should be safe, isn't it?
> >>> 
> >>> It probably is. But you need to save modules. 
> >>I just consider the region from kernel start(1M) to the end of rodata.
> >>In my test, the region is about 4M memory. Just adding 
> >several lines to
> >>save 4M memory is worthy.
> >
> >Why it is safe? :-)  If you think BIOS as a black box, and don't know
> >how BIOS works,
> >then, you have to save them for safety concern. 
> >
> s/BIOS/Modules/
As I said, I just consider the region from kernel start to the end of
rodata (get from the link script). modules should be saved/restored as
normal.

Thanks,
Shaohua


--===============79559463453120816==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============79559463453120816==--
