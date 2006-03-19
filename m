From: Pavel Machek <pavel@ucw.cz>
Subject: Re: CE Linux Forum PM Requierments WiKi is available for
	review and comment.
Date: Sun, 19 Mar 2006 19:22:07 +0000
Message-ID: <20060319192207.GB2389@ucw.cz>
References: <F760B14C9561B941B89469F59BA3A8470D05388E@orsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============20844683153966526=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470D05388E@orsmsx401.amr.corp.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Gross, Mark" <mark.gross@intel.com>
Cc: linux-pm@osdl.org, PMWG@LIST.CELINUXFORUM.ORG, mli_tech@groups.osdl.org, celinux-dev@tree.celinuxforum.org
List-Id: linux-pm@vger.kernel.org

--===============20844683153966526==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Please do not post html to the lists.

> Please visit
> http://tree.celinuxforum.org/CelfPubWiki/CELFPmRequirements2006
> 
>  
> 
> This is a simple draft requirements document listing the candidate items
> that may be included in a final PM requirements PDF document.  The CELF
> PM Working group is trying to define a set of requirements from which
> some projects and investigations will be derived.  We very much welcome
> input and ideas from the larger development community.
... 
> All public comments, private comments, and WiKi edits are welcome.


4. device power management seems to be missing. What is "OS
throttling"? 

You seem to want to do device throttling. Device powering off should
be there, too.

5.1 you seem to dislike ACPI, but I guess you should add proposal to
new /sys interface.

6.1 "UI responsiveness governor"? That sounds more like usermode
governor, and we have that one already. Thermal governor should not be
needed, it should be included in *every* governor.

7.1 if your hardware can damage itself or hurt user *FIX YOUR
HARDWARE*! Will you argue that overcharging li-ion to explosion is also ok?

9 uswsusp should be able to suspend-to-flash.

9.2 yep, I'm telling you this is easy to do. No need to change kernel,
even, just needs recent -mm.

								Pavel
-- 
Thanks, Sharp!

--===============20844683153966526==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============20844683153966526==--
