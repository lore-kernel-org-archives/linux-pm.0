From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 2/2] PM: Lock all devices during
	suspend/hibernate
Date: Wed, 1 Aug 2007 17:37:52 +0200
Message-ID: <200708011737.52513.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0708011008570.3764-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0708011008570.3764-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 1 August 2007 16:11, Alan Stern wrote:
> On Wed, 1 Aug 2007, Rafael J. Wysocki wrote:
> 
> > > +static DECLARE_RWSEM(device_registration_rwsem);
> > 
> > Is it only intended for device registration, or can it be used in some other
> > code paths too?
> 
> The patch uses it only for registration, since that's where it is 
> needed.  I suppose it could be used on other paths as well, if anybody 
> wanted to make something else mutually exclusive with suspend.  
> (Although then it probably ought to be renamed...)

That was exactly my thought.  Why don't we give it a more general name from
the start?

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
