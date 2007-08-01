From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Possible problem with device_move()
Date: Wed, 1 Aug 2007 11:22:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0708011119380.3764-100000@iolanthe.rowland.org>
References: <20070801150332.41f447c8@gondolin.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070801150332.41f447c8@gondolin.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-pm@lists.linux-foundation.org, Marcel Holtmann <marcel@holtmann.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 1 Aug 2007, Cornelia Huck wrote:

> On Tue, 31 Jul 2007 16:37:03 -0400 (EDT),
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > Still, I suppose it would be best to add a "move device A to the end of
> > the dpm_active list" routine for use in this sort of situation.  This 
> > should be easy to do.
> 
> Would it make sense if device_move() moved the new parent (and its
> parents) after the device in the dpm_active list automatically? Then we
> would only have to worry about reordering manually in very special
> cases.

As it stands right now, every place device_move() gets called is 
already special!

I'm afraid of reordering devices automatically; there's too much 
potential for creating new problems.  When a driver calls device_move() 
or does something similar, it should know what sort of list 
rearrangement is safe.  But the PM core can't be expected to know.

Alan Stern
