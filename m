From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: freeze_processes questions
Date: Wed, 6 Apr 2005 14:26:58 -0700
Message-ID: <200504061426.59285.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0504061702260.1634-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============27296835128852059=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0504061702260.1634-100000@ida.rowland.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============27296835128852059==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 06 April 2005 2:03 pm, Alan Stern wrote:
> On Wed, 6 Apr 2005, Rafael J. Wysocki wrote:
> 
> > Frankly, I can't see any probable scenario leading to this kind of trouble.
> > Seemingly, it would require someone to take a lock and (knowingly) do
> > something that could end up in uninterruptible sleep, which IMHO is not
> > a good idea.
> 
> It happens all the time in the USB core, when dealing with a 
> newly-connected device.

True, it does happen then.  One of many examples of where the USB team
must regularly deal with issues that some simpler driver stacks are able
to avoid ... or at least think they're able to avoid.  (Hotplugging and
hot-unplugging tend to complicate things.)

That said, why wouldn't that be a good idea?  The locking infrastructure
in Linux was certainly designed to make that work properly.  And it's
common in other operating systems too.  Tasks block each other all the
time; it's simpler to adopt that model than the alternatives, and hence
a lot easier to maintain.

- Dave

--===============27296835128852059==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============27296835128852059==--
