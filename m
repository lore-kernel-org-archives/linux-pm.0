From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: rtl8187 usb wifi adaptor causes suspend hang
Date: Thu, 01 Jan 2009 13:07:48 +0000
Message-ID: <495CC024.9020009__40742.5952530049$1230815501$gmane$org@tuffmail.co.uk>
References: <471208.74701.qm@web23104.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <471208.74701.qm@web23104.mail.ird.yahoo.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: htl10@users.sourceforge.net
Cc: Bob Copeland <me@bobcopeland.com>, USB list <linux-usb@vger.kernel.org>, linux-wireless@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, linux-pm@lists.linux-foundation.org, Larry Finger <Larry.Finger@lwfinger.net>
List-Id: linux-pm@vger.kernel.org

Hin-Tak Leung wrote:
> --- On Wed, 31/12/08, Alan Jenkins <alan-jenkins@tuffmail.co.uk> wrote:
>
>   
>> Thanks for the patch.  I tested STD too, and it doesn't
>> seem to hang
>> anymore.  I even tested removing the adaptor while the
>> system was
>> hibernated.  However, after resume the interface is
>> useless.
>>     
>
> Wierd - do you have NetworkManager running?
>   

Yes, but it's not managing the wireless interface - I'm still using the
wired network.  When I tested, I didn't use the wireless interface at
all before I hibernated.

> These days I leave NM running - besides the occasional /etc/rc.d/init.d/{wpa_supplicant/NetworkManager} stop/start to re-establish connectivity (seems to be some timing issue with dhcp taking too long and nm ifconfig up/down the device wrongly) - and *when STD/STR works*, NM usually just re-connect within a minute on resume/defrost.
>
> I don't have the choice of unhooking the device - integrated to laptop. BTW, is it a B device or a non-B device that didn't work?
>   

I think it's a B device.

phy0: hwaddr 00:1b:2f:76:02:bc, RTL8187vB (default) V1 + rtl8225z2


Alan
