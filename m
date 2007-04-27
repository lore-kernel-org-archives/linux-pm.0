From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [RFC/PATCH 2/2] driver core: power management debugging
Date: Fri, 27 Apr 2007 17:13:47 +0300
Message-ID: <84144f020704270713g7ea2907bib8ce1aad76ba5a93@mail.gmail.com>
References: <Pine.LNX.4.64.0704271525071.11149@sbz-30.cs.Helsinki.FI>
	<Pine.LNX.4.44L0.0704271004090.3430-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0704271004090.3430-100000@iolanthe.rowland.org>
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
Cc: nigel@nigel.suspend2.net, linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

On 4/27/07, Alan Stern <stern@rowland.harvard.edu> wrote:
> Now perhaps you would prefer to check the USB interface drivers -- there
> are many of them, and quite a few don't have suspend or resume methods.
> You would need to modify usb_register_driver() instead of
> usb_register_device_driver().

I'll change that. Thanks.

On 4/27/07, Alan Stern <stern@rowland.harvard.edu> wrote:
> On the other hand, the drivers' maintainers are probably quite aware of
> the missing PM support, so it's not clear that printing out warning
> messages will actually help anybody.

It will help to debug a swsusp problem that is reported by a non-developer, no?
