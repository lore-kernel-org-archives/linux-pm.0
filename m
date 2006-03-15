From: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp: which page should be saved?
Date: Wed, 15 Mar 2006 23:08:46 +0000
Message-ID: <20060315230846.GB2462@ucw.cz>
References: <1142481207.26706.16.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============42060233786528811=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1142481207.26706.16.camel@sli10-desk.sh.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============42060233786528811==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu 16-03-06 11:53:27, Shaohua Li wrote:
> I thought there was a discussion before, but I still saw many pages like
> BIOS reserved are saved/restored in swsusp. Pages reserved by BIOS, not
> used by OS and kernel text should be skipped in swsusp to me. Below
> patch works in my test. Any thought?

This will need quite a lot of testing.

Does it actually fix anything?

I'm afraid that some of the BIOSs state is actually shared knowledge
with kernel, and that we should better save it, so that kernel's and
BIOS's view are consistent after resume.

Arguably such pieces should better have their own suspend/resume
methods, but...

								Pavel
-- 
Thanks, Sharp!

--===============42060233786528811==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============42060233786528811==--
