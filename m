From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC] userland swsusp
Date: Wed, 16 Nov 2005 19:10:52 +0000
Message-ID: <20051116191051.GG2193@spitz.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============73541056070751876=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============73541056070751876==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> I worry that this is just adding more thrash to a historically unstable
> implementation.  How long do we users have to wait for a swsusp
> implementation where we don't have to worry about breaking from one
> kernel release to the next?

What unstable implementation? swsusp had very little regressions over past
year or so. Drivers were different story, but nothing changes w.r.t. drivers.

								Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


--===============73541056070751876==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============73541056070751876==--
