From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: Freezer: Don't count threads waiting for
	frozen	filesystems.
Date: Fri, 31 Oct 2008 00:04:02 +1100
Message-ID: <1225371842.8576.6.camel__17635.0261121572$1225332395$gmane$org@nigel-laptop>
References: <Pine.LNX.4.44L0.0810291627040.3986-100000@iolanthe.rowland.org>
	<200810292211.49021.rjw@sisk.pl>
	<1225316715.18786.1.camel@nigel-laptop>
	<E1KvKm8-0000cP-6f@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1KvKm8-0000cP-6f@pomaz-ex.szeredi.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi.

On Thu, 2008-10-30 at 00:48 +0100, Miklos Szeredi wrote:
> On Thu, 30 Oct 2008, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Wed, 2008-10-29 at 22:11 +0100, Rafael J. Wysocki wrote:
> > > The current design of the freezer is rather simplistic and I'm not really sure
> > > it's the best one possible.  Perhaps we can redesign the freezer to work
> > > differently and handle the cases like fuse.
> > 
> > Why redo what I've already done? In the full patch, you have the basis
> > of what you're talking about. I haven't seen a failure to freeze fuse or
> > anything else in a year of use.
> 
> Well yeah, your patch handles the straightforward cases.  But it
> doesn't help with the more tricky cases, where one fuse filesystem is
> using another, and as those may become more widespread, this approach
> will fail.

At the moment, yes. But it's not impossible for us to modify the patch
to handle that as well.

Regards,

Nigel
