From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Freezer: Don't count threads waiting for frozen
 filesystems.
Date: Thu, 30 Oct 2008 09:56:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0810300955020.2401-100000@iolanthe.rowland.org>
References: <1225371842.8576.6.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1225371842.8576.6.camel@nigel-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

On Fri, 31 Oct 2008, Nigel Cunningham wrote:

> > Well yeah, your patch handles the straightforward cases.  But it
> > doesn't help with the more tricky cases, where one fuse filesystem is
> > using another, and as those may become more widespread, this approach
> > will fail.
> 
> At the moment, yes. But it's not impossible for us to modify the patch
> to handle that as well.

It depends on what you mean.  The most direct reading of your statement
is simply wrong: It is _theoretically_ impossible to find the correct
order for freezing filesystems.  To do so would be equivalent to
solving the halting problem.

Alan Stern
