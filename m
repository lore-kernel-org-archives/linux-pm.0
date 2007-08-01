From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: Re: Possible problem with device_move()
Date: Wed, 1 Aug 2007 15:03:32 +0200
Message-ID: <20070801150332.41f447c8@gondolin.boeblingen.de.ibm.com>
References: <200707312112.51043.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0707311628150.2787-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707311628150.2787-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, Marcel Holtmann <marcel@holtmann.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 31 Jul 2007 16:37:03 -0400 (EDT),
Alan Stern <stern@rowland.harvard.edu> wrote:

> Still, I suppose it would be best to add a "move device A to the end of
> the dpm_active list" routine for use in this sort of situation.  This 
> should be easy to do.

Would it make sense if device_move() moved the new parent (and its
parents) after the device in the dpm_active list automatically? Then we
would only have to worry about reordering manually in very special
cases.
