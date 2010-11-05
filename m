From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: HCD polling root hub status before controller is
 brought out of suspend
Date: Fri, 5 Nov 2010 16:09:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1011051606160.6245-100000@netrider.rowland.org>
References: <AANLkTikFH-ULHTkn0YEaMY_wyYhWm15AEujF-Arm28Do@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikFH-ULHTkn0YEaMY_wyYhWm15AEujF-Arm28Do@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maksim Rayskiy <maksim.rayskiy@gmail.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Please use reply-to-all so that your email will be sent to the mailing 
list.

On Fri, 5 Nov 2010, Maksim Rayskiy wrote:

> Thank you, Alan.
> 
> I do not see ohci_bus_suspend/ohci_bus_resume clearing/setting
> HCD_FLAG_HW_ACCESSIBLE bit. Does that mean we have to deal with this in our
> own driver then?

Yes.  This is because controller registers may or may not become
inaccessible during suspend, depending on the hardware.  See
ohci_pci_suspend() for an example.

Alan Stern
