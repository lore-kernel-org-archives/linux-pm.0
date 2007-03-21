From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 32-bit user suspend program on 64-bit kernel?
Date: Wed, 21 Mar 2007 15:05:52 +0100
Message-ID: <200703211505.52812.rjw@sisk.pl>
References: <1174468281.3769.7.camel@johannes.berg>
	<20070321122820.GA4523@elf.ucw.cz>
	<1174480277.4230.9.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174480277.4230.9.camel@johannes.berg>
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
To: linux-pm@lists.linux-foundation.org
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 21 March 2007 13:31, Johannes Berg wrote:
> On Wed, 2007-03-21 at 13:28 +0100, Pavel Machek wrote:
> =

> > > compat code for the ioctl which shares pointers and structs, is there
> > > any way to make it possible?
> > =

> > That means that either ioctl is very hw-specific, or you've found a
> > bug.
> =

> I think I'll just have to give it a try.

Unfortunately the numbers of ioctls are not portable due to my rookie mista=
ke
in the beginning (using void * in _IOW() and friends which passed with no
objections).

I'm ashamed of that, but it's probably too late to fix it. :-(

Greetings,
Rafael
