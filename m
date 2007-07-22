From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Re: Hibernation considerations
Date: Sun, 22 Jul 2007 18:27:43 +0200
Message-ID: <E1ICeHX-00025u-00@dorka.pomaz.szeredi.hu>
References: <Pine.LNX.4.44L0.0707221116060.15224-100000@netrider.rowland.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <Pine.LNX.4.44L0.0707221116060.15224-100000@netrider.rowland.org>
	(message from Alan Stern on Sun, 22 Jul 2007 11:26:23 -0400 (EDT))
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: stern@rowland.harvard.edu
Cc: david@lang.hm, miklos@szeredi.hu, nigel@suspend2.net, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, jbms@cmu.edu
List-Id: linux-pm@vger.kernel.org

> The only thing to do is what Rafael has been working on: unfreeze
> things, hope the tasks sort themselves out, and try again.

Have we some proof, that this will untangle the freezing tasks in a
limited time?  Or will it just make the problem harder to trigger?

Miklos
