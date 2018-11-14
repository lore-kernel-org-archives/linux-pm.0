From: Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH RFC 0/6] mm/kdump: allow to exclude pages that are
 logically offline
Date: Wed, 14 Nov 2018 22:57:51 +0000
Message-ID: <8932E1F4-A5A9-4462-9800-CAC1EF85AC5D@vmware.com>
References: <20181114211704.6381-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114211704.6381-1-david@redhat.com>
Content-Language: en-US
Content-ID: <8127D4BDFD768A4B9EE74019E7FFB6E1@namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>, linux-mm <linux-mm@kvack.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Christian Hansen <chansen3@cisco.com>, Dave Young <dyoung@redhat.com>, David Rientjes <rientjes@google.com>, Haiyang Zhang <haiyangz@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>, Ka
List-Id: linux-pm@vger.kernel.org

From: David Hildenbrand
Sent: November 14, 2018 at 9:16:58 PM GMT
> Subject: [PATCH RFC 0/6] mm/kdump: allow to exclude pages that are logica=
lly offline
>=20
>=20
> Right now, pages inflated as part of a balloon driver will be dumped
> by dump tools like makedumpfile. While XEN is able to check in the
> crash kernel whether a certain pfn is actuall backed by memory in the
> hypervisor (see xen_oldmem_pfn_is_ram) and optimize this case, dumps of
> virtio-balloon and hv-balloon inflated memory will essentially result in
> zero pages getting allocated by the hypervisor and the dump getting
> filled with this data.

Is there any reason that VMware balloon driver is not mentioned?
