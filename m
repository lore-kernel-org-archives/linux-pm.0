Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931EB421A12;
	Mon, 13 Jul 2026 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948652; cv=none; b=tiuHVpIvhwWTjwcDz5pvh8E9d6tU61yzIWVu9fMQRvrOewaeSbSQzddx6YqdC9w8Ja0lbK67IShqXCXRYHk7iZDRwUj7zyiSCrJXgdD2Wyfb05CgNWJLnPKMb3Xi8PFKnTceEyixprIdnzJQuRBiMtuoa5y40t5LR5yWtfhrS9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948652; c=relaxed/simple;
	bh=JC/lJ/HQkfsfbILDjKPqLOhuX83T5J4LJVMmn5qmLxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKl14u5Mcht4YSsFKi/RDp8BfoZ8XYHcFsHZCAPP/he0aEsjA8J3iz/owfXTGGq4Y4wo9ndrvljuSUii59TpH+oeRbhaz7hIr0oogNpfMRwxc4FO1GeL38uY4YqvBElqC7oX5VLkZsee8hpW+bIOpTurR29a7f8SENaGvvYBL2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KC6Q+GXh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KC6Q+GXh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C30D1F000E9;
	Mon, 13 Jul 2026 13:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783948651;
	bh=CTDzIuECg7ec2CujzD4dfEzEhYJme9GipSqlqXXMpj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KC6Q+GXhttKsbu9CWEw31Iy/WZwxMdPA/KSPis3lfiKK/wLCqQbVrZvDCW9ARu5Gl
	 QabXyKFrVUYprBT5dwjhN8f5YfSIW7/bmZwo8EHj5wWB8lU86Pj3y8+Ko0QLSVSQZz
	 ZbZPb9nSrvcaZI30VFQ6H8UX5vAEG3in4ywlOyxpPuSXzkVwxnA3GOCW0dosrzHanm
	 96Dk3ofjo/sBxx5S402dwbfF/WyPxf7s4n7ni5hXzI4GHp8FqNr7HzHVZ5kEkuirLg
	 SJI/K/h3IzGl8AaCcLdgo9FdkjtIg5xwfGI19pq2gKkKmgS4KmYW0fyxG8t+/mW+//
	 IOtz88h0vnPqg==
Date: Mon, 13 Jul 2026 14:17:28 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 05/17] ACPI: processor: idle: Split
 acpi_processor_evaluate_lpi()
Message-ID: <20260713-debonair-imposing-stingray-1aa12b@sudeepholla>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <10878273.nUPlyArG6x@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10878273.nUPlyArG6x@rafael.j.wysocki>

On Thu, Jul 09, 2026 at 02:34:36PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Move individual _LPI state package processing from
> acpi_processor_evaluate_lpi() to a separate new function
> called process_lpi_state_package().
> 
> No intentional functional impact.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
