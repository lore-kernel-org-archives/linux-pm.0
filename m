From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Trying to understand new wakeup events architecture
Date: Thu, 13 Jan 2011 10:14:04 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1101131012090.2022-100000@iolanthe.rowland.org>
References: <1294931188.2244.5.camel@polyethylene>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1294931188.2244.5.camel@polyethylene>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 13 Jan 2011, Daniel Drake wrote:

> As for contents, it will read back a string. One of:
> 
> rtc alarm
> power button
> lid
> key press
> battery
> battery state changed
> battery error
> ebook
> wlan packet
> ac power
> battery critical
> gp timer
> hda
> usb
> unknown

Wouldn't it be better to read back a device pathname when the wakeup
source can be identified as a particular device?  Whoever uses this 
field should be responsible for converting it to one of those more 
generic forms.

Alan Stern
