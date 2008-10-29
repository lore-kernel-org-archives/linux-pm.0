From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Freezer: Don't count threads waiting for frozen
	filesystems.
Date: Wed, 29 Oct 2008 23:56:00 +0000
Message-ID: <20081029235600.GA5993__32804.6747869395$1225324717$gmane$org@srcf.ucam.org>
References: <E1KvDcp-0008B7-SR@pomaz-ex.szeredi.hu>
	<Pine.LNX.4.44L0.0810291627040.3986-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0810291627040.3986-100000@iolanthe.rowland.org>
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
Cc: ncunningham@crca.org.au, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 29, 2008 at 04:37:30PM -0400, Alan Stern wrote:

> I discussed this last summer with Rafael.  It's a lot harder than it 
> looks, for all sorts of reasons.  For example, what about user tasks 
> that have access to memory-mapped I/O regions?

The only interesting cases of this I know of are X (which ought to stop 
doing so in the near future) and certain sound operations (which are 
going via a well-defined API anyway and need to handle devices going 
away at random, so not a problem). There may be some other niche cases, 
but really - if you're mmapping hardware then it's generally because you 
haven't written a proper kernel driver. Do that instead. Runtime power 
management's already going to make you wildly unhappy.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
