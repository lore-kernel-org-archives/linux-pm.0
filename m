From: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp3: system suspend/resume from userspace
Date: Thu, 1 Sep 2005 22:17:14 +0200
Message-ID: <20050901201714.GA2027@openzaurus.ucw.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B30047B8E51@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============058822765803868249=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30047B8E51@hdsmsx401.amr.corp.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Nigel Cunningham <ncunningham@linuxmail.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============058822765803868249==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > shrink kernel a bit at the same time.
> 
> got numbers (or predicted numbers)?

30-50% of swsusp.c deals with swap writing, and with swsusp3, they could
be removed.  Of course, removal would take some time before people install userland
"write image" programs.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


--===============058822765803868249==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============058822765803868249==--
