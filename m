From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC Add no_suspend attribute V2] Let the driver
 know if it's in use
Date: Thu, 23 Jul 2009 10:56:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0907231053040.2825-100000@iolanthe.rowland.org>
References: <200907231632.40243.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200907231632.40243.rjw@sisk.pl>
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
Cc: Greg KH <greg@kroah.com>, linux-pm@lists.linux-foundation.org, len.brown@intel.com
List-Id: linux-pm@vger.kernel.org

On Thu, 23 Jul 2009, Rafael J. Wysocki wrote:

> > I follow the discussion around the new runtime support and I would like 
> > to know if I can
> > add to the new interface the no_suspend flag or maybe now there is a 
> > better solution.
> 
> Hmm.  Do I remember correctly that the no_suspend flag is for preventing the
> system-wide suspend in case some devices are in use?

As I recall, the no_suspend flag was used to mark a few devices which
should not be powered down during an otherwise normal system sleep.

For example, you might want to suspend the computer while leaving a
built-in DVB tuner on because the tuner is attached to an external TV
set.

Alan Stern
