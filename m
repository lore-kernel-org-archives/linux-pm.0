From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 2/8] introduce the device async action
	mechanism
Date: Thu, 16 Jul 2009 21:31:06 -0700
Message-ID: <20090716213106.32d61d53__2668.24503564767$1247805050$gmane$org@infradead.org>
References: <1247643516.26272.77.camel@rzhang-dt>
	<20090715060006.71c2e2b6@infradead.org>
	<1247709910.26272.159.camel@rzhang-dt>
	<200907170312.00006.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200907170312.00006.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, "Van De Ven,
	Arjan" <arjan.van.de.ven@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 17 Jul 2009 03:11:59 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> 
> Well, first, I'm not really sure that using the async _boot_
> infrastructure for that is a good choice. 

the async function call mechanism is for more than boot.



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
