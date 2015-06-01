From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 4/8] klist: implement klist_prev()
Date: Mon, 1 Jun 2015 10:21:21 +0900
Message-ID: <20150601012121.GA22743@kroah.com>
References: <1432570172-86963-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1432570172-86963-5-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432570172-86963-5-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, May 25, 2015 at 07:09:28PM +0300, Andy Shevchenko wrote:
> klist_prev() gets the previous element in the list. It is useful to traverse
> through the list in reverse order, for example, to provide LIFO (last in first
> out) variant of access.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Acked-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
