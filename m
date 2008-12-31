From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: rtl8187 usb wifi adaptor causes suspend hang
Date: Wed, 31 Dec 2008 17:10:01 +0000
Message-ID: <495BA769.4060702__10327.3475230255$1230743705$gmane$org@tuffmail.co.uk>
References: <348894.23448.qm@web23108.mail.ird.yahoo.com>
	<495B82CB.6050205@tuffmail.co.uk>
	<20081231155757.GA26806@hash.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081231155757.GA26806@hash.localnet>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bob Copeland <me@bobcopeland.com>
Cc: USB list <linux-usb@vger.kernel.org>, linux-wireless@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, htl10@users.sourceforge.net, linux-pm@lists.linux-foundation.org, Larry Finger <Larry.Finger@lwfinger.net>
List-Id: linux-pm@vger.kernel.org

Bob Copeland wrote:
> On Wed, Dec 31, 2008 at 02:33:47PM +0000, Alan Jenkins wrote:
>   
>> Thanks for the patch.  I tested STD too, and it doesn't seem to hang
>> anymore.  I even tested removing the adaptor while the system was
>> hibernated.  However, after resume the interface is useless.
>>     
>
> Kind of sounds like the hardware is not responding... so this probably
> won't help, but you can always give my patches a spin:
>
>     http://bobcopeland.com/kernel/wl/20081214/
>
> Should apply with fuzz.  Just ignore patch 3, also you don't need 
> anything special for rtl8187 since the classdev will suspend/resume
> on its own and rtl8187 already didn't do anything special for PM.
>   

You were right, they didn't help :-).  Thanks anyway.
