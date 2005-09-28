From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Problems with PM_FREEZE
Date: Thu, 29 Sep 2005 00:01:38 +0200
Message-ID: <20050928220138.GL2506@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0509281528410.5193-100000@iolanthe.rowland.org>
	<200509282356.07108.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============36893567375105896=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200509282356.07108.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@cyclades.com>
List-Id: linux-pm@vger.kernel.org

--===============36893567375105896==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > Yes, I've been thinking about it for some time.  It seems to me we could do
> > > this with the help of an additional field in pm_message_t.
> > 
> > The problem that no pm_message_t is passed to resume routines.
> 
> Yes, shame on me (I desperately need some sleep).
> 
> How about calling *_suspend() twice, first before the image is created
> and second after it has been created but before *_resume() are called,
> with the second call only telling the driver the next resume will be
> resume-during-suspend? 

Could we do it properly and pass pm_message_t to resume()? Yes, it is
more work, but no, we don't need hacks there.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============36893567375105896==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============36893567375105896==--
