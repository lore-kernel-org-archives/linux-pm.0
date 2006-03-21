From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: Re: swsusp: which page should be saved?
Date: Tue, 21 Mar 2006 11:41:02 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B417451@pdsmsx403>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============098265080903963797=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============098265080903963797==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

>> >>> It probably is. But you need to save modules. 
>> >>I just consider the region from kernel start(1M) to the 
>end of rodata.
>> >>In my test, the region is about 4M memory. Just adding 
>> >several lines to
>> >>save 4M memory is worthy.
>> >
>> >Why it is safe? :-)  If you think BIOS as a black box, and 
>don't know
>> >how BIOS works,
>> >then, you have to save them for safety concern. 
>> >
>> s/BIOS/Modules/
>As I said, I just consider the region from kernel start to the end of
>rodata (get from the link script). modules should be saved/restored as
>normal.

I'm not sure if this a real case, but I'm sure in this case
kernel text needs to be saved too if  the kernel 
has been patched with binary patch at run-time.

Thanks,
Luming


--===============098265080903963797==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============098265080903963797==--
