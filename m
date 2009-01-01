From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: rtl8187 usb wifi adaptor causes suspend hang
Date: Thu, 1 Jan 2009 06:18:52 +0000 (GMT)
Message-ID: <471208.74701.qm__34972.2775551074$1230910695$gmane$org@web23104.mail.ird.yahoo.com>
References: <495B82CB.6050205@tuffmail.co.uk>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <495B82CB.6050205@tuffmail.co.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Bob Copeland <me@bobcopeland.com>, USB list <linux-usb@vger.kernel.org>, linux-wireless@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, linux-pm@lists.linux-foundation.org, Larry Finger <Larry.Finger@lwfinger.net>
List-Id: linux-pm@vger.kernel.org

--- On Wed, 31/12/08, Alan Jenkins <alan-jenkins@tuffmail.co.uk> wrote:

> Thanks for the patch.  I tested STD too, and it doesn't
> seem to hang
> anymore.  I even tested removing the adaptor while the
> system was
> hibernated.  However, after resume the interface is
> useless.

Wierd - do you have NetworkManager running?

These days I leave NM running - besides the occasional /etc/rc.d/init.d/{wpa_supplicant/NetworkManager} stop/start to re-establish connectivity (seems to be some timing issue with dhcp taking too long and nm ifconfig up/down the device wrongly) - and *when STD/STR works*, NM usually just re-connect within a minute on resume/defrost.

I don't have the choice of unhooking the device - integrated to laptop. BTW, is it a B device or a non-B device that didn't work?

Hin-Tak 


      
