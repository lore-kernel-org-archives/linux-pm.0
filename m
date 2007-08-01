From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC 2/2] PM: Lock all devices during
	suspend/hibernate
Date: Wed, 1 Aug 2007 10:11:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0708011008570.3764-100000@iolanthe.rowland.org>
References: <200708010020.47144.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708010020.47144.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 1 Aug 2007, Rafael J. Wysocki wrote:

> > +static DECLARE_RWSEM(device_registration_rwsem);
> 
> Is it only intended for device registration, or can it be used in some other
> code paths too?

The patch uses it only for registration, since that's where it is 
needed.  I suppose it could be used on other paths as well, if anybody 
wanted to make something else mutually exclusive with suspend.  
(Although then it probably ought to be renamed...)

Alan Stern
