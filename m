From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: Possible problem with device_move()
Date: Tue, 31 Jul 2007 17:30:27 +0200
Message-ID: <20070731173027.02934c71@gondolin.boeblingen.de.ibm.com>
References: <20070731103305.39b76a5d@gondolin.boeblingen.de.ibm.com>
	<Pine.LNX.4.44L0.0707311104270.3520-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707311104270.3520-100000@iolanthe.rowland.org>
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
Cc: Marcel Holtmann <marcel@holtmann.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 31 Jul 2007 11:11:50 -0400 (EDT),
Alan Stern <stern@rowland.harvard.edu> wrote:

> I wonder if device_move() shouldn't change the order of entries in the 
> dpm_active list so that the new parent (and all its ancestors) get 
> moved up ahead of the device's position?  But that might cause other 
> problems...

This may be necessary if walking the list is the single determining
factor to the order of suspend/resume. Are there any other dependencies
not covered by time of registration order? I would imagine those needed
moving devices on the dpm_active list as well...
