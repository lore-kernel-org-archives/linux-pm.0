From: David Brownell <david-b@pacbell.net>
Subject: Re: Alternative Concept
Date: Tue, 20 Mar 2007 15:04:46 -0700
Message-ID: <200703201504.47956.david-b@pacbell.net>
References: <200703182104.27555.david-b@pacbell.net>
	<46003329.6050808@gmail.com> <20070320204514.GH3545@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070320204514.GH3545@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 20 March 2007 1:45 pm, Pavel Machek wrote:

> > If I understand you correctly, you are against big debates unless a
> > patch is ready,
> =

> You understood it well.

Thing is, this hasn't even gotten to the level of "debate".
The "alternative" is at this point pure handwaving.

The reason to insist on a patch is primarily to ensure that
peoples' time doesn't get wasted.  There are ways to make a
concrete proposal that don't involve patches.  But in this
case, we haven't seen any of them.  So it's fair to ask for
something more concrete, such as a few patches...


> But we do not want new subsystem. We want power management to
> work. Take a look how Alan added pm to usb... and just do it like
> him. If some code makes sense to be shared, share it. But start with
> support for platform you care about and don't overdesign it.

Note, Alan didn't do it by himself.  The autosuspend stuff built on
previous work in USB PM, and this DID get discussed -- as concrete
proposals -- before he did all that good stuff.

- Dave
