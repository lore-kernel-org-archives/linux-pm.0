From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC 2/3] Runtime PM support for named power states
Date: Mon, 3 Oct 2005 15:19:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0510031515370.5909-100000@iolanthe.rowland.org>
References: <20051003181406.06C97EE8D4@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============21173356359471662=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051003181406.06C97EE8D4@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============21173356359471662==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 3 Oct 2005, David Brownell wrote:

> Actually, the line below should use "level" not "PCI_D3hot", since the
> reason to enable wake from D3hot is that D3hot was the target state.
> 
> And if the target isn't D3hot, it may not be necessary to enable wake
> from D3cold ... the reason to enable wake from D3cold is that it's
> not currently knowable if system suspend is going to morph the D3hot
> into a D3cold.
> 
> IMO it's probably fair to ignore D3cold except if the target is D3hot.

And for now we probably want to ignore the whole thing for runtime 
suspends, since Linux doesn't properly handle PME signals.  Unless the 
system is going to sleep, we should avoid generating them.

Alan Stern


--===============21173356359471662==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============21173356359471662==--
