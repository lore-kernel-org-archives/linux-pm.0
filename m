From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: swsusp3: system suspend/resume from userspace
Date: Wed, 21 Sep 2005 09:41:39 +1000
Message-ID: <1127259699.4386.82.camel@gaston>
References: <F7DC2337C7631D4386A2DF6E8FB22B30047B8E51@hdsmsx401.amr.corp.intel.com>
	<20050901201714.GA2027@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5131930953294086=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050901201714.GA2027@openzaurus.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

--===============5131930953294086==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-09-01 at 22:17 +0200, Pavel Machek wrote:
> Hi!
> 
> > > shrink kernel a bit at the same time.
> > 
> > got numbers (or predicted numbers)?
> 
> 30-50% of swsusp.c deals with swap writing, and with swsusp3, they could
> be removed.  Of course, removal would take some time before people install userland
> "write image" programs.

I have trouble understanding how you can make that work without all sort
of interesting races though... 

Ben.



--===============5131930953294086==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============5131930953294086==--
