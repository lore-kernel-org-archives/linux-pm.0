From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: rtl8187 usb wifi adaptor causes suspend hang
Date: Tue, 30 Dec 2008 12:25:15 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0812301220090.2386-100000__34301.0500110269$1230658056$gmane$org@iolanthe.rowland.org>
References: <b6c5339f0812300845y169ee09dwccbc03ff63cf6525@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <b6c5339f0812300845y169ee09dwccbc03ff63cf6525@mail.gmail.com>
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
Cc: linux-wireless@vger.kernel.org, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>
List-Id: linux-pm@vger.kernel.org

On Tue, 30 Dec 2008, Bob Copeland wrote:

> On Tue, Dec 30, 2008 at 10:45 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> >> Is it possible to fix this without suspend support in mac80211?  If not,
> >> I vote we change rtl8187 (and zd_usb) to prevent suspend.  I.e. set USB
> >> suspend callbacks which return an error.
> 
> Alan J:
> 
> Are you using 'echo -n mem > /sys/power/state' directly to do suspend,
> or hitting the power button?  I'm guessing we shouldn't be calling
> disconnect() when suspending.
> 
> > It certainly should be possible to fix this.  For instance, why
> > unregister anything during suspend?  If ieee80211_unregister_hw()
> > weren't called then this problem would go away, right?
> 
> Yes, we shouldn't need to.
> 
> But it's not the suspend() callback that's getting called (the driver
> doesn't have one) but disconnect, which unregisters itself from the
> upper layers.  I just read the stuff in Documentation/usb but admit I
> don't fully get the rules.  AIUI, without suspend/resume callbacks,
> disconnect will sometimes get called on resume?  But the original
> email is a hang at suspend time?

This explains the problem.  Yes, drivers that don't have a suspend or
resume method will have their disconnect method called when a system
suspend occurs.

An easy way to prevent this is to add empty suspend and resume methods 
(and a resume_reset method too).

Alternatively, you can allow the disconnect to occur.  If the workqueue 
weren't freezable then the problem would be solved.  Which leads to the 
question: Why have a freezable workqueue if there's no suspend/resume 
support in the driver?

Alan Stern
