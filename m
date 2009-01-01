From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: rtl8187 usb wifi adaptor causes suspend hang
Date: Thu, 1 Jan 2009 06:06:38 +0000 (GMT)
Message-ID: <584629.91849.qm__33843.1179560304$1230910681$gmane$org@web23108.mail.ird.yahoo.com>
References: <495BC8F9.4040203@lwfinger.net>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <495BC8F9.4040203@lwfinger.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Larry Finger <Larry.Finger@lwfinger.net>
Cc: Bob Copeland <me@bobcopeland.com>, USB list <linux-usb@vger.kernel.org>, linux-wireless@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--- On Wed, 31/12/08, Larry Finger <Larry.Finger@lwfinger.net> wrote:
<snipped>
> Thanks for testing. I have some ideas on how to improve the
> suspend/resume, but they will require some changes in the
> structure. I
> will also try to determine why my system fails at STR so I
> can test
> both flavors.

I had a crash STR, after restoring my SUSPEND_MODULES workaround , so it is possible that the new addition actually stop the module getting unloaded. In any case, I suggest testing STR/STD while leaving a ping to the router running, just to be sure that the suspend/resume code does the right thing.

Also since Alan Stern is now CC'ed, can I ask the in-tree skeleton usb driver code updated to reflect the recent PM-related changes? There seems to be quite some changes between 2.6.26 and 2.6.27 .

Cheers,
Hin-Tak 


      
