From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC PATCH 2/4] ACPI: introduce the mechanism
	to	save/restore ACPI NVS memory
Date: Wed, 9 Jul 2008 11:58:50 -0300
Message-ID: <20080709145850.GA18230__9245.37255564264$1215615712$gmane$org@khazad-dum.debian.net>
References: <1215051874.5628.34.camel@rzhang-dt.sh.intel.com>
	<200807040134.15094.rjw@sisk.pl> <20080708193558.GC8694@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080708193558.GC8694@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, linux-kernel <linux-kernel@zh-kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 08 Jul 2008, Pavel Machek wrote:
> > >  static int acpi_hibernation_begin(void)
> > >  {
> > >  	acpi_target_sleep_state = ACPI_STATE_S4;
> > >  
> > > -	return 0;
> > > +	/* allocate pages for ACPI NVS memory before swsusp_shrink_memory */
> > > +	return acpi_allocate_nvs_pages();
> > 
> > I think we shouldn't abort hibernation because of that.
> > 
> > This may be an emergency hibernation due to critical battery status and we
> > surely don't want to about that.
> 
> I disagree here. If spec says 'you must save this', and we don't, we
> are asking for subtle, dangerous, and very hard to repoduce problems.

Indeed.  Especially after we start doing the right thing, and vendors WILL
expect us to do the right thing (save the NVS memory) *always*, not just
"almost always".

If you don't want the hibernate path to fail because of OOM, have whatever
memory it needs pre-allocated, set aside and protected at startup so that it
will always be there when you need to hibernate.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
