From: Greg KH <gregkh@suse.de>
Subject: Re: [RFC/PATCH] platform_bus: allow custom extensions to
 system PM methods
Date: Wed, 17 Mar 2010 16:44:14 -0700
Message-ID: <20100317234414.GA23319__19430.1811549396$1268869541$gmane$org@suse.de>
References: <1268867896-7616-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1268867896-7616-1-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, linux-kernel@vger.kernel.org, Magnus Damm <damm@opensource.se>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 17, 2010 at 04:18:15PM -0700, Kevin Hilman wrote:
> When runtime PM for platform_bus was added, it allowed for platforms
> to customize the runtime PM methods since they are defined as weak
> symbols.
> 
> This patch allows platforms to also extend the system PM methods with
> custom hooks so runtime PM and system PM extensions can be managed
> together by custom platform-specific code.

Wow, that's scary, I didn't realize that was done for the runtime stuff.

What would you be replacing these functions with for your platform that
would require it to be in arch-specific code?

thanks,

greg k-h
