From: "Bob Copeland" <me@bobcopeland.com>
Subject: Re: rtl8187 usb wifi adaptor causes suspend hang
Date: Tue, 30 Dec 2008 11:45:06 -0500
Message-ID: <b6c5339f0812300845y169ee09dwccbc03ff63cf6525__1443.44227524034$1230655816$gmane$org@mail.gmail.com>
References: <495A1DC8.1050609@tuffmail.co.uk>
	<Pine.LNX.4.44L0.0812301043290.2292-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0812301043290.2292-100000@iolanthe.rowland.org>
Content-Disposition: inline
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
Cc: linux-wireless@vger.kernel.org, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 30, 2008 at 10:45 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> Is it possible to fix this without suspend support in mac80211?  If not,
>> I vote we change rtl8187 (and zd_usb) to prevent suspend.  I.e. set USB
>> suspend callbacks which return an error.

Alan J:

Are you using 'echo -n mem > /sys/power/state' directly to do suspend,
or hitting the power button?  I'm guessing we shouldn't be calling
disconnect() when suspending.

> It certainly should be possible to fix this.  For instance, why
> unregister anything during suspend?  If ieee80211_unregister_hw()
> weren't called then this problem would go away, right?

Yes, we shouldn't need to.

But it's not the suspend() callback that's getting called (the driver
doesn't have one) but disconnect, which unregisters itself from the
upper layers.  I just read the stuff in Documentation/usb but admit I
don't fully get the rules.  AIUI, without suspend/resume callbacks,
disconnect will sometimes get called on resume?  But the original
email is a hang at suspend time?

The drivers themselves actually shouldn't be doing much in suspend
callbacks once mac80211 suspend support is done -- just powering down
the device -- since mac80211 will handle all the softmac state.

-- 
Bob Copeland %% www.bobcopeland.com
