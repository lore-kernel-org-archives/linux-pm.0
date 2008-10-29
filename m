From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Freezer: Don't count threads waiting for
	frozen	filesystems.
Date: Thu, 30 Oct 2008 00:48:32 +0100
Message-ID: <E1KvKm8-0000cP-6f__29311.2065447078$1225324260$gmane$org@pomaz-ex.szeredi.hu>
References: <Pine.LNX.4.44L0.0810291627040.3986-100000@iolanthe.rowland.org>
	<200810292211.49021.rjw@sisk.pl>
	<1225316715.18786.1.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1225316715.18786.1.camel@nigel-laptop> (message from Nigel
	Cunningham on Thu, 30 Oct 2008 08:45:15 +1100)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ncunningham@crca.org.au
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, miklos@szeredi.hu
List-Id: linux-pm@vger.kernel.org

On Thu, 30 Oct 2008, Nigel Cunningham wrote:
> Hi.
> 
> On Wed, 2008-10-29 at 22:11 +0100, Rafael J. Wysocki wrote:
> > The current design of the freezer is rather simplistic and I'm not really sure
> > it's the best one possible.  Perhaps we can redesign the freezer to work
> > differently and handle the cases like fuse.
> 
> Why redo what I've already done? In the full patch, you have the basis
> of what you're talking about. I haven't seen a failure to freeze fuse or
> anything else in a year of use.

Well yeah, your patch handles the straightforward cases.  But it
doesn't help with the more tricky cases, where one fuse filesystem is
using another, and as those may become more widespread, this approach
will fail.

Miklos
