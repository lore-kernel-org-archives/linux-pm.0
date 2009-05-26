From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Tue, 26 May 2009 17:56:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0905261754250.11998-100000__2557.94863119281$1243375032$gmane$org@iolanthe.rowland.org>
References: <1243373613.13930.61.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1243373613.13930.61.camel@nigel-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@tuxonice.net>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 27 May 2009, Nigel Cunningham wrote:

> USB devices ought to be able to do _something_ though - I have a Dvico
> Dual Digital 4 card

What is that?

> that is forcing me to shutdown X, mythtv-backend,
> pulse audio and lirc at the moment so that I can rmmod it while
> hibernating. That ought not be necessary. I'm sure there are good
> technical reasons why it is necessary at the mooment, but it shouldn't
> be that way - even if it just does the bare minimum required to avoid
> requiring the closing of files and the unload.

Probably the driver's author just never got around to adding support
for suspend/resume.  Which driver is it?  What happens if you don't 
rmmod it?

Alan Stern
