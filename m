From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: Hotplug events during sleep transition
Date: Thu, 5 Jan 2006 19:05:02 +0000
Message-ID: <20060105190502.GA2520@ucw.cz>
References: <20060104233158.GA1796@elf.ucw.cz>
	<Pine.LNX.4.44L0.0601051102180.5520-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============89364110910078187=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0601051102180.5520-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============89364110910078187==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu 05-01-06 11:07:52, Alan Stern wrote:
> On Thu, 5 Jan 2006, Pavel Machek wrote:
> > On St 28-12-05 21:18:38, Alan Stern wrote:
> > > On Wed, 28 Dec 2005, Rafael J. Wysocki wrote:
> > 
> > ...for reasonable buses, like usb. For something like ps/2, .resume is
> > the place to check, I'm afraid.
> 
> It's _a_ place to check.  On the other hand, since there's no checking 
> anywhere else, why does there need to be a check in .resume?

You are not normally sending commands to ps/2 mouse, except
when initializing it. And you have to re-initialize it during
.resume. You'll notice that commands time out...

...well, you *could* just ignore the timeouts :-).


-- 
Thanks, Sharp!

--===============89364110910078187==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============89364110910078187==--
