From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 0/8] device async action mechanism
Date: Thu, 16 Jul 2009 08:40:20 -0300
Message-ID: <20090716114020.GA11928__45468.4889446527$1247744494$gmane$org@khazad-dum.debian.net>
References: <1247643512.26272.74.camel@rzhang-dt>
	<87ocrm6xeq.fsf@basil.nowhere.org>
	<1247710483.26272.170.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1247710483.26272.170.camel@rzhang-dt>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Van De Ven,
	Arjan" <arjan.van.de.ven@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, arjan@linux.intel.com
List-Id: linux-pm@vger.kernel.org

On Thu, 16 Jul 2009, Zhang Rui wrote:
> the kernel device suspend time is reduced from 3.2s to 2.8s after
> applying this patch set in my test box.

It will give even a bigger boot time saving on ThinkPads, where there is a
Synaptics (or ALPS if you are unlucky) touchpad with the trackpoint behind
it... it takes about 2s to init both devices here.  That's two seconds of
boot time you can shove off if it is being initialized assyncronously :-)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
