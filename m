From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: rtl8187 usb wifi adaptor causes suspend hang
Date: Tue, 30 Dec 2008 16:48:16 +0000
Message-ID: <495A50D0.3080000__7654.76206220246$1230655987$gmane$org@tuffmail.co.uk>
References: <495A1DC8.1050609@tuffmail.co.uk>	
	<Pine.LNX.4.44L0.0812301043290.2292-100000@iolanthe.rowland.org>
	<b6c5339f0812300845y169ee09dwccbc03ff63cf6525@mail.gmail.com>
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
Cc: linux-wireless@vger.kernel.org, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Bob Copeland wrote:
> On Tue, Dec 30, 2008 at 10:45 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
>   
>>> Is it possible to fix this without suspend support in mac80211?  If not,
>>> I vote we change rtl8187 (and zd_usb) to prevent suspend.  I.e. set USB
>>> suspend callbacks which return an error.
>>>       
>
> Alan J:
>
> Are you using 'echo -n mem > /sys/power/state' directly to do suspend,
> or hitting the power button?

Various.  Normally I use my GUI, which is using s2disk.  I did try using
/sys/power/state directly as well, but there was no difference.
