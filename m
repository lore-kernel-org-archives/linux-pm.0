From: david@lang.hm
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Tue, 11 Mar 2008 17:09:32 -0700 (PDT)
Message-ID: <alpine.DEB.1.00.0803111708270.32330__23545.1280874715$1205280774$gmane$org@asgard.lang.hm>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080311211004.GA30164@redhat.com>
	<1205272758.7990.37.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1205272758.7990.37.camel@nigel-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 12 Mar 2008, Nigel Cunningham wrote:

> 3. Usability.
>
> Right now, kexec based hibernation looks quite complicated to configure,
> and the user is apparently going to have to remember to boot a different
> kernel or at least a different bootloader entry in order to resume. Not
> a plus. It would be good if you could find a way to use one bootloader
> entry, resuming if there's an image, booting normally if there's not.

I don't see any reason why this couldn't be done with an initrd to decide 
if you are doing a normal boot or a restore.

David Lang
