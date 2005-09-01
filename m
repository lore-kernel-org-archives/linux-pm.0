From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: swsusp3: system suspend/resume from userspace
Date: Fri, 02 Sep 2005 07:13:32 +1000
Message-ID: <1125609211.4785.32.camel@localhost>
References: <F7DC2337C7631D4386A2DF6E8FB22B30047B8E51@hdsmsx401.amr.corp.intel.com>
	<20050901201714.GA2027@openzaurus.ucw.cz>
Reply-To: ncunningham@linuxmail.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============81513388354347349=="
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============81513388354347349==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Fri, 2005-09-02 at 06:17, Pavel Machek wrote:
> Hi!
> 
> > > shrink kernel a bit at the same time.
> > 
> > got numbers (or predicted numbers)?
> 
> 30-50% of swsusp.c deals with swap writing, and with swsusp3, they could
> be removed.  Of course, removal would take some time before people install userland
> "write image" programs.

You're also going to have to add code to interface with userspace and
pass the data. I wouldn't be surprised if the net effect is a growth in
the code.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.


--===============81513388354347349==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============81513388354347349==--
