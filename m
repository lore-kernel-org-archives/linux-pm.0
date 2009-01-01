From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: rtl8187 usb wifi adaptor causes suspend hang
Date: Wed, 31 Dec 2008 19:16:44 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0812311915350.12880-100000__4159.34626148573$1230769153$gmane$org@netrider.rowland.org>
References: <495BF975.7030603@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <495BF975.7030603@lwfinger.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Bob Copeland <me@bobcopeland.com>, USB list <linux-usb@vger.kernel.org>, linux-wireless@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, htl10@users.sourceforge.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 31 Dec 2008, Larry Finger wrote:

> Here is a second try at a suspend/resume patch for rtl8187. This one
> also seems a bit too easy; however, it did work for me, at least for
> STD. I now realize that my machine didn't power off in my previous
> test. This time I manually turned it off before restarting. My
> computer still doesn't STR, thus that was not tested.

As Oliver pointed out, you generally need to implement a reset_resume
method for hibernation to work.  See 
Documentation/usb/power-management.txt.

Alan Stern
